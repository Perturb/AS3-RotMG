// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.Panel

package com.google.analytics.debug
{
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.events.MouseEvent;
    import flash.display.Graphics;
    import flash.display.DisplayObject;

    public class Panel extends UISprite 
    {

        private var _savedH:uint;
        private var _data:UISprite;
        private var _mask:Sprite;
        private var _background:Shape;
        private var _savedW:uint;
        private var _stickToEdge:Boolean;
        private var _border:Shape;
        private var _borderColor:uint;
        protected var baseAlpha:Number;
        private var _backgroundColor:uint;
        private var _title:Label;
        private var _colapsed:Boolean;
        private var _name:String;

        public function Panel(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint=0, _arg_5:uint=0, _arg_6:Number=0.3, _arg_7:Align=null, _arg_8:Boolean=false)
        {
            _name = _arg_1;
            this.name = _arg_1;
            this.mouseEnabled = false;
            _colapsed = false;
            forcedWidth = _arg_2;
            forcedHeight = _arg_3;
            this.baseAlpha = _arg_6;
            _background = new Shape();
            _data = new UISprite();
            _data.forcedWidth = _arg_2;
            _data.forcedHeight = _arg_3;
            _data.mouseEnabled = false;
            _title = new Label(_arg_1, "uiLabel", 0xFFFFFF, Align.topLeft, _arg_8);
            _title.buttonMode = true;
            _title.margin.top = 0.6;
            _title.margin.left = 0.6;
            _title.addEventListener(MouseEvent.CLICK, onToggle);
            _title.mouseChildren = false;
            _border = new Shape();
            _mask = new Sprite();
            _mask.useHandCursor = false;
            _mask.mouseEnabled = false;
            _mask.mouseChildren = false;
            if (_arg_7 == null)
            {
                _arg_7 = Align.none;
            };
            this.alignement = _arg_7;
            this.stickToEdge = _arg_8;
            if (_arg_4 == 0)
            {
                _arg_4 = Style.backgroundColor;
            };
            _backgroundColor = _arg_4;
            if (_arg_5 == 0)
            {
                _arg_5 = Style.borderColor;
            };
            _borderColor = _arg_5;
        }

        public function get stickToEdge():Boolean
        {
            return (_stickToEdge);
        }

        public function onToggle(_arg_1:MouseEvent=null):void
        {
            if (_colapsed)
            {
                _data.visible = true;
            }
            else
            {
                _data.visible = false;
            };
            _colapsed = (!(_colapsed));
            _update();
            resize();
        }

        public function set stickToEdge(_arg_1:Boolean):void
        {
            _stickToEdge = _arg_1;
            _title.stickToEdge = _arg_1;
        }

        override protected function dispose():void
        {
            _title.removeEventListener(MouseEvent.CLICK, onToggle);
            super.dispose();
        }

        private function _draw():void
        {
            var _local_1:uint;
            var _local_2:uint;
            if (((_savedW) && (_savedH)))
            {
                forcedWidth = _savedW;
                forcedHeight = _savedH;
            };
            if (!_colapsed)
            {
                _local_1 = forcedWidth;
                _local_2 = forcedHeight;
            }
            else
            {
                _local_1 = _title.width;
                _local_2 = _title.height;
                _savedW = forcedWidth;
                _savedH = forcedHeight;
                forcedWidth = _local_1;
                forcedHeight = _local_2;
            };
            var _local_3:Graphics = _background.graphics;
            _local_3.clear();
            _local_3.beginFill(_backgroundColor);
            Background.drawRounded(this, _local_3, _local_1, _local_2);
            _local_3.endFill();
            var _local_4:Graphics = _data.graphics;
            _local_4.clear();
            _local_4.beginFill(_backgroundColor, 0);
            Background.drawRounded(this, _local_4, _local_1, _local_2);
            _local_4.endFill();
            var _local_5:Graphics = _border.graphics;
            _local_5.clear();
            _local_5.lineStyle(0.1, _borderColor);
            Background.drawRounded(this, _local_5, _local_1, _local_2);
            _local_5.endFill();
            var _local_6:Graphics = _mask.graphics;
            _local_6.clear();
            _local_6.beginFill(_backgroundColor);
            Background.drawRounded(this, _local_6, (_local_1 + 1), (_local_2 + 1));
            _local_6.endFill();
        }

        public function get title():String
        {
            return (_title.text);
        }

        private function _update():void
        {
            _draw();
            if (baseAlpha < 1)
            {
                _background.alpha = baseAlpha;
                _border.alpha = baseAlpha;
            };
        }

        public function addData(_arg_1:DisplayObject):void
        {
            _data.addChild(_arg_1);
        }

        override protected function layout():void
        {
            _update();
            addChild(_background);
            addChild(_data);
            addChild(_title);
            addChild(_border);
            addChild(_mask);
            mask = _mask;
        }

        public function set title(_arg_1:String):void
        {
            _title.text = _arg_1;
        }

        public function close():void
        {
            dispose();
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }


    }
}//package com.google.analytics.debug

