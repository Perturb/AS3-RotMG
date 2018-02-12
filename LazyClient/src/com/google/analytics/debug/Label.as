// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.Label

package com.google.analytics.debug
{
    import flash.display.Shape;
    import flash.text.TextField;
    import flash.events.TextEvent;
    import flash.display.Graphics;
    import flash.text.TextFieldType;
    import flash.text.TextFieldAutoSize;

    public class Label extends UISprite 
    {

        public static var count:uint = 0;

        private var _color:uint;
        private var _background:Shape;
        private var _textField:TextField;
        public var stickToEdge:Boolean;
        private var _text:String;
        protected var selectable:Boolean;
        private var _tag:String;

        public function Label(_arg_1:String="", _arg_2:String="uiLabel", _arg_3:uint=0, _arg_4:Align=null, _arg_5:Boolean=false)
        {
            this.name = ("Label" + count++);
            selectable = false;
            _background = new Shape();
            _textField = new TextField();
            _text = _arg_1;
            _tag = _arg_2;
            if (_arg_4 == null)
            {
                _arg_4 = Align.none;
            };
            this.alignement = _arg_4;
            this.stickToEdge = _arg_5;
            if (_arg_3 == 0)
            {
                _arg_3 = Style.backgroundColor;
            };
            _color = _arg_3;
            _textField.addEventListener(TextEvent.LINK, onLink);
        }

        public function get tag():String
        {
            return (_tag);
        }

        private function _draw():void
        {
            var _local_1:Graphics = _background.graphics;
            _local_1.clear();
            _local_1.beginFill(_color);
            var _local_2:uint = _textField.width;
            var _local_3:uint = _textField.height;
            if (forcedWidth > 0)
            {
                _local_2 = forcedWidth;
            };
            Background.drawRounded(this, _local_1, _local_2, _local_3);
            _local_1.endFill();
        }

        public function get text():String
        {
            return (_textField.text);
        }

        public function appendText(_arg_1:String, _arg_2:String=""):void
        {
            if (_arg_1 == "")
            {
                return;
            };
            if (_arg_2 == "")
            {
                _arg_2 = tag;
            };
            _textField.htmlText = (_textField.htmlText + (((('<span class="' + _arg_2) + '">') + _arg_1) + "</span>"));
            _text = (_text + _arg_1);
            _draw();
            resize();
        }

        public function set text(_arg_1:String):void
        {
            if (_arg_1 == "")
            {
                _arg_1 = _text;
            };
            _textField.htmlText = (((('<span class="' + tag) + '">') + _arg_1) + "</span>");
            _text = _arg_1;
            _draw();
            resize();
        }

        override protected function layout():void
        {
            _textField.type = TextFieldType.DYNAMIC;
            _textField.autoSize = TextFieldAutoSize.LEFT;
            _textField.background = false;
            _textField.selectable = selectable;
            _textField.multiline = true;
            _textField.styleSheet = Style.sheet;
            this.text = _text;
            addChild(_background);
            addChild(_textField);
        }

        public function set tag(_arg_1:String):void
        {
            _tag = _arg_1;
            text = "";
        }

        public function onLink(_arg_1:TextEvent):void
        {
        }

        override protected function dispose():void
        {
            _textField.removeEventListener(TextEvent.LINK, onLink);
            super.dispose();
        }


    }
}//package com.google.analytics.debug

