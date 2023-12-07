shopOpen=false;
global.shop=false;

selected=0;
selectedAnim = 0;

//global.itemLibrary;


itemCount=ds_list_size(global.items);

//GUI
guiWidth=display_get_gui_width();
guiHeight=display_get_gui_height();

menuWidth=guiWidth*0.5;
menuMargin=guiWidth*0.1;

previewWidth=(guiWidth-(menuWidth+menuMargin));
