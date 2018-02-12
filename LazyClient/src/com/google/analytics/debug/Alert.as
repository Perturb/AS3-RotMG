// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.Alert

package com.google.analytics.debug
{
    import flash.events.TextEvent;

    public class Alert extends Label 
    {

        public var autoClose:Boolean = true;
        public var actionOnNextLine:Boolean = true;
        private var _actions:Array;

        public function Alert(_arg_1:String, _arg_2:Array, _arg_3:String="uiAlert", _arg_4:uint=0, _arg_5:Align=null, _arg_6:Boolean=false, _arg_7:Boolean=true)
        {
            if (_arg_4 == 0)
            {
                _arg_4 = Style.alertColor;
            };
            if (_arg_5 == null)
            {
                _arg_5 = Align.center;
            };
            super(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6);
            this.selectable = true;
            super.mouseChildren = true;
            this.buttonMode = true;
            this.mouseEnabled = true;
            this.useHandCursor = true;
            this.actionOnNextLine = _arg_7;
            _actions = [];
            var _local_8:int;
            while (_local_8 < _arg_2.length)
            {
                _arg_2[_local_8].container = this;
                _actions.push(_arg_2[_local_8]);
                _local_8++;
            };
        }

        private function _defineActions():void
        {
            var _local_3:AlertAction;
            var _local_1:* = "";
            if (actionOnNextLine)
            {
                _local_1 = (_local_1 + "\n");
            }
            else
            {
                _local_1 = (_local_1 + " |");
            };
            _local_1 = (_local_1 + " ");
            var _local_2:Array = [];
            var _local_4:int;
            while (_local_4 < _actions.length)
            {
                _local_3 = _actions[_local_4];
                _local_2.push((((('<a href="event:' + _local_3.activator) + '">') + _local_3.name) + "</a>"));
                _local_4++;
            };
            _local_1 = (_local_1 + _local_2.join(" | "));
            appendText(_local_1, "uiAlertAction");
        }

        protected function isValidAction(_arg_1:String):Boolean
        {
            var _local_2:int;
            while (_local_2 < _actions.length)
            {
                if (_arg_1 == _actions[_local_2].activator)
                {
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }

        override protected function layout():void
        {
            super.layout();
            _defineActions();
        }

        protected function getAction(_arg_1:String):AlertAction
        {
            var _local_2:int;
            while (_local_2 < _actions.length)
            {
                if (_arg_1 == _actions[_local_2].activator)
                {
                    return (_actions[_local_2]);
                };
                _local_2++;
            };
            return (null);
        }

        protected function spaces(_arg_1:int):String
        {
            var _local_2:* = "";
            var _local_3:* = "          ";
            var _local_4:int;
            while (_local_4 < (_arg_1 + 1))
            {
                _local_2 = (_local_2 + _local_3);
                _local_4++;
            };
            return (_local_2);
        }

        override public function onLink(_arg_1:TextEvent):void
        {
            var _local_2:AlertAction;
            if (isValidAction(_arg_1.text))
            {
                _local_2 = getAction(_arg_1.text);
                if (_local_2)
                {
                    _local_2.execute();
                };
            };
            if (autoClose)
            {
                close();
            };
        }

        public function close():void
        {
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }


    }
}//package com.google.analytics.debug

