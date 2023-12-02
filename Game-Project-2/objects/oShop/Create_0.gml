shopOpen=false;
global.shop=false;

selected=0;
selectedAnim = 0;

items=ds_list_create();

ds_list_add(items, ["item1", 10, "Health1"]);
ds_list_add(items, ["item2", 20, "Health2"]);
ds_list_add(items, ["item3", 30, "Health3"]);
ds_list_add(items, ["item4", 40, "Health4"]);
ds_list_add(items, ["item5", 50, "Health5"]);

itemCount=ds_list_size(items);

//GUI
guiWidth=display_get_gui_width();
guiHeight=display_get_gui_height();

menuWidth=guiWidth*0.5;
menuMargin=guiWidth*0.1;

previewWidth=(guiWidth-(menuWidth+menuMargin));