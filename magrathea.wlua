require "cdlua"
require "iuplua"
require "iupluacd"

require "cdluacontextplus"

--activate GDI+
cd.UseContextPlus(1)

mapui=iup.canvas{rastersize="300x200"}

function mapui:map_cb()
  can=cd.CreateCanvas(cd.IUP,self)
end

function mapui:action()
  can:Activate()
  can:Clear()
end

function mapui:button_cb(button,pressed,x,y,r)
  if pressed == 1 then
    if not held then held={} end
    held[button]=true
    ButtonAction(x,y)

  --for some reason IUP doesn't send further button=0
  --events after releasing 1 button regardless of what
  --buttons were held prior
  --(eg. after pushing button1, pushing button 2,
  --and releasing button1,
  --releasing button2 will not call button_cb)
  --so just treat a pressed==0 as the release of all buttons
  else
    held=nil
  end
end

function mapui:motion_cb(x,y,status)
  if held then
    ButtonAction(x,y)
  end
end

function ButtonAction(x,y)
  y=can:UpdateYAxis(y)
  can:Sector(x,y,10,10,0,360)
end

function modeselect(title)
  return iup.button{title=title,expand="YES";
    action=function (self)
      currentmode=self.title
    end}
end

butts=iup.vbox{
  modeselect "Cities",
  modeselect "Rivers",
  modeselect "Regions",
  modeselect "Notes"
  ;margin=0
}

iup.dialog{title="Magrathea";margin="2x2",gap=2;iup.hbox{mapui,butts}}:show()

iup.MainLoop()
