var pixels = require('image-pixels')
import ImageEditor from 'tui-image-editor'
import 'tui-image-editor'


//var ImageEditor = require('tui-image-editor');
//var FileSaver = require('file-saver'); //to download edited image to local. Use after npm install file-saver
//var blackTheme = require('./js/theme/black-theme.js');
var blackTheme = {

    // main icons
    'menu.normalIcon.color': '#8a8a8a',
    'menu.activeIcon.color': '#555555',
    'menu.disabledIcon.color': '#434343',
    'menu.hoverIcon.color': '#e9e9e9',
    'menu.iconSize.width': '24px',
    'menu.iconSize.height': '24px',

    // submenu icons
    'submenu.normalIcon.color': '#8a8a8a',
    'submenu.activeIcon.color': '#e9e9e9',
    'submenu.iconSize.width': '32px',
    'submenu.iconSize.height': '32px',

    // submenu primary color
    'submenu.backgroundColor': '#1e1e1e',
    'submenu.partition.color': '#3c3c3c',

    // submenu labels
    'submenu.normalLabel.color': '#8a8a8a',
    'submenu.normalLabel.fontWeight': 'lighter',
    'submenu.activeLabel.color': '#fff',
    'submenu.activeLabel.fontWeight': 'lighter',

    // checkbox style
    'checkbox.border': '0px',
    'checkbox.backgroundColor': '#fff',

    // range style
    'range.pointer.color': '#fff',
    'range.bar.color': '#666',
    'range.subbar.color': '#d1d1d1',

    'range.disabledPointer.color': '#414141',
    'range.disabledBar.color': '#282828',
    'range.disabledSubbar.color': '#414141',

    'range.value.color': '#fff',
    'range.value.fontWeight': 'lighter',
    'range.value.fontSize': '11px',
    'range.value.border': '1px solid #353535',
    'range.value.backgroundColor': '#151515',
    'range.title.color': '#fff',
    'range.title.fontWeight': 'lighter',

    // colorpicker style
    'colorpicker.button.border': '1px solid #1e1e1e',
    'colorpicker.title.color': '#fff'
};

function bufferToBase64(buf){
  var data = Array.prototype.map.call(buf, function(char){
    return String.fromCharCode(char);
  }).join('');
  return btoa(data);
}

$(document).ready(() => {
  var instance;

  instance = new ImageEditor('#tui-image-editor', {
    includeUI: {
      loadImage: {
          path: 'images/blankMessage.bmp',
          name: 'SampleImage'
      },
      theme: blackTheme, // or whiteTheme
      menuBarPosition: 'bottom',
  },
      cssMaxWidth: 700,
      cssMaxHeight: 500
  });

  $("form#create_message").submit((e) => {
    console.log(e);
    if(!e.isTrigger){
      e.preventDefault();
      //console.log(instance);
      var img = instance.toDataURL();
      //console.log(pixels);
      convertImage(img);
    }
  });

  function arrayToRGB(red, green, blue){
    red = red >> 3;
    green = green >> 2;
    blue = blue >> 3;
    return blue + (green << 5) + (red << 11);
  }

  async function convertImage(img){
    var loaded = await pixels(img);
    console.log(loaded);
    var converted = new Uint8Array(loaded.width * loaded.height * 2);
    for( var i = 0; i < loaded.data.length; i += 4){
      var rgb = arrayToRGB(loaded.data[i], loaded.data[i+1], loaded.data[i+2]);
      if(i < 50){ console.log(rgb);}
      converted[i/2] = rgb & 255;
      converted[i/2+1] = rgb >> 8;
    }
    console.log(converted);
    console.log(bufferToBase64(converted));
    document.getElementById('message_image').value = bufferToBase64(converted);
    $("form#create_message").submit();
    //$("form#create_message").unbind("submit");
  }
});
