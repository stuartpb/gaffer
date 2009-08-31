--[[
HIGH CONCEPT:
a fiction-writing manager

-lay out maps (currently seperate in "magrathea.lua")
-write universal tenets
-write themes
-write stories
  -detect continuity errors based on established tenets and facts of prior events
]]
require "iuplua"
require "rex"

tenets=iup.list
{
size="100", expand="VERTICAL"
}

function put_it_there(self,c,newtext)
  local i=1
  for before, match in rex.split(newtext, "\n") do
    tenets[i]=before
    i=i+1
  end
end

iup.dialog{
  iup.hbox{
    iup.multiline{expand="YES",action=put_it_there},
    iup.frame{tenets;title="Related lines"}
  }
  ;menu=iup.menu{
    iup.submenu{title="File"; iup.menu{
      iup.item{title="Open..."},
      iup.item{title="Save..."},
      iup.item{title="Quit",action=function() return iup.CLOSE end}
    }}
  }
  ;size="HALFxHALF",title="The Continuicon",margin="2x2"
}:show()

iup.MainLoop()
