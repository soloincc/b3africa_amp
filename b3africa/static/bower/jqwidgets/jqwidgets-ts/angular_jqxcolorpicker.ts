/*
jQWidgets v4.5.2 (2017-May)
Copyright (c) 2011-2017 jQWidgets.
License: http://jqwidgets.com/license/
*/
/// <reference path="jqwidgets.d.ts" />
import { Component, Input, Output, EventEmitter, ElementRef, forwardRef, OnChanges, SimpleChanges } from '@angular/core';
declare let $: any;

@Component({
    selector: 'jqxColorPicker',
    template: '<div><ng-content></ng-content></div>'
})

export class jqxColorPickerComponent implements OnChanges
{
   @Input('color') attrColor: any;
   @Input('colorMode') attrColorMode: any;
   @Input('disabled') attrDisabled: any;
   @Input('showTransparent') attrShowTransparent: any;
   @Input('width') attrWidth: any;
   @Input('height') attrHeight: any;

   @Input('auto-create') autoCreate: boolean = true;

   properties: string[] = ['color','colorMode','disabled','height','showTransparent','width'];
   host: any;
   elementRef: ElementRef;
   widgetObject:  jqwidgets.jqxColorPicker;

   constructor(containerElement: ElementRef) {
      this.elementRef = containerElement;
   }

   ngOnInit() {
      if (this.autoCreate) {
         this.createComponent(); 
      }
   }; 

   ngOnChanges(changes: SimpleChanges) {
      if (this.host) {
         for (let i = 0; i < this.properties.length; i++) {
            let attrName = 'attr' + this.properties[i].substring(0, 1).toUpperCase() + this.properties[i].substring(1);
            let areEqual: boolean;

            if (this[attrName] !== undefined) {
               if (typeof this[attrName] === 'object') {
                  if (this[attrName] instanceof Array) {
                     areEqual = this.arraysEqual(this[attrName], this.host.jqxColorPicker(this.properties[i]));
                  }
                  if (areEqual) {
                     return false;
                  }

                  this.host.jqxColorPicker(this.properties[i], this[attrName]);
                  continue;
               }

               if (this[attrName] !== this.host.jqxColorPicker(this.properties[i])) {
                  this.host.jqxColorPicker(this.properties[i], this[attrName]); 
               }
            }
         }
      }
   }

   arraysEqual(attrValue: any, hostValue: any): boolean {
      if (attrValue.length != hostValue.length) {
         return false;
      }
      for (let i = 0; i < attrValue.length; i++) {
         if (attrValue[i] !== hostValue[i]) {
            return false;
         }
      }
      return true;
   }

   manageAttributes(): any {
      let options = {};
      for (let i = 0; i < this.properties.length; i++) {
         let attrName = 'attr' + this.properties[i].substring(0, 1).toUpperCase() + this.properties[i].substring(1);
         if (this[attrName] !== undefined) {
            options[this.properties[i]] = this[attrName];
         }
      }
      return options;
   }

   createComponent(options?: any): void {
      if (options) {
         $.extend(options, this.manageAttributes());
      }
      else {
        options = this.manageAttributes();
      }
      this.host = $(this.elementRef.nativeElement.firstChild);
      this.__wireEvents__();
      this.widgetObject = jqwidgets.createInstance(this.host, 'jqxColorPicker', options);

      this.__updateRect__();
   }

   createWidget(options?: any): void {
        this.createComponent(options);
   }

   __updateRect__() : void {
      this.host.css({ width: this.attrWidth, height: this.attrHeight });
   }

   setOptions(options: any) : void {
      this.host.jqxColorPicker('setOptions', options);
   }

   // jqxColorPickerComponent properties
   color(arg?: any) : any {
      if (arg !== undefined) {
          this.host.jqxColorPicker('color', arg);
      } else {
          return this.host.jqxColorPicker('color');
      }
   }

   colorMode(arg?: string) : any {
      if (arg !== undefined) {
          this.host.jqxColorPicker('colorMode', arg);
      } else {
          return this.host.jqxColorPicker('colorMode');
      }
   }

   disabled(arg?: boolean) : any {
      if (arg !== undefined) {
          this.host.jqxColorPicker('disabled', arg);
      } else {
          return this.host.jqxColorPicker('disabled');
      }
   }

   height(arg?: jqwidgets.Size) : any {
      if (arg !== undefined) {
          this.host.jqxColorPicker('height', arg);
      } else {
          return this.host.jqxColorPicker('height');
      }
   }

   showTransparent(arg?: boolean) : any {
      if (arg !== undefined) {
          this.host.jqxColorPicker('showTransparent', arg);
      } else {
          return this.host.jqxColorPicker('showTransparent');
      }
   }

   width(arg?: jqwidgets.Size) : any {
      if (arg !== undefined) {
          this.host.jqxColorPicker('width', arg);
      } else {
          return this.host.jqxColorPicker('width');
      }
   }


   // jqxColorPickerComponent functions
   getColor(): Object {
      return this.host.jqxColorPicker('getColor');
   }

   setColor(color: any): void {
      this.host.jqxColorPicker('setColor', color);
   }


   // jqxColorPickerComponent events
   @Output() onColorchange = new EventEmitter();

   __wireEvents__(): void {
      this.host.on('colorchange', (eventData: any) => { this.onColorchange.emit(eventData); });
   }

} //jqxColorPickerComponent


