" Font
if exists(':GuiFont')
  if has('win32')
    GuiFont! DejaVuSansMono NF:h9
  else
    GuiFont! DejaVuSansMono Nerd Font Mono 10
  endif
endif

" Controls
if exists(':GuiTabline')
  GuiTabline 0
endif

if exists(':GuiPopupmenu')
  GuiPopupmenu 1
endif

if exists(':GuiScrollBar')
  GuiScrollBar 0
endif
