// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.UISprite

package com.google.analytics.debug
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.display.Stage;

    public class UISprite extends Sprite 
    {

        private var _forcedWidth:uint;
        public var margin:Margin;
        protected var alignTarget:DisplayObject;
        protected var listenResize:Boolean;
        public var alignement:Align;
        private var _forcedHeight:uint;

        public function UISprite(_arg_1:DisplayObject=null)
        {
            listenResize = false;
            alignement = Align.none;
            this.alignTarget = _arg_1;
            margin = new Margin();
            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
        }

        public function get forcedHeight():uint
        {
            if (_forcedHeight)
            {
                return (_forcedHeight);
            };
            return (height);
        }

        private function _onAddedToStage(_arg_1:Event):void
        {
            layout();
            resize();
        }

        protected function dispose():void
        {
            var _local_1:DisplayObject;
            var _local_2:int;
            while (_local_2 < numChildren)
            {
                _local_1 = getChildAt(_local_2);
                if (_local_1)
                {
                    removeChild(_local_1);
                };
                _local_2++;
            };
        }

        public function set forcedHeight(_arg_1:uint):void
        {
            _forcedHeight = _arg_1;
        }

        public function set forcedWidth(_arg_1:uint):void
        {
            _forcedWidth = _arg_1;
        }

        protected function layout():void
        {
        }

        public function get forcedWidth():uint
        {
            if (_forcedWidth)
            {
                return (_forcedWidth);
            };
            return (width);
        }

        public function alignTo(_arg_1:Align, _arg_2:DisplayObject=null):void
        {
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:UISprite;
            if (_arg_2 == null)
            {
                if ((parent is Stage))
                {
                    _arg_2 = this.stage;
                }
                else
                {
                    _arg_2 = parent;
                };
            };
            if (_arg_2 == this.stage)
            {
                if (this.stage == null)
                {
                    return;
                };
                _local_3 = this.stage.stageHeight;
                _local_4 = this.stage.stageWidth;
                _local_5 = 0;
                _local_6 = 0;
            }
            else
            {
                _local_7 = (_arg_2 as UISprite);
                if (_local_7.forcedHeight)
                {
                    _local_3 = _local_7.forcedHeight;
                }
                else
                {
                    _local_3 = _local_7.height;
                };
                if (_local_7.forcedWidth)
                {
                    _local_4 = _local_7.forcedWidth;
                }
                else
                {
                    _local_4 = _local_7.width;
                };
                _local_5 = 0;
                _local_6 = 0;
            };
            switch (_arg_1)
            {
                case Align.top:
                    x = ((_local_4 / 2) - (forcedWidth / 2));
                    y = (_local_6 + margin.top);
                    break;
                case Align.bottom:
                    x = ((_local_4 / 2) - (forcedWidth / 2));
                    y = (((_local_6 + _local_3) - forcedHeight) - margin.bottom);
                    break;
                case Align.left:
                    x = (_local_5 + margin.left);
                    y = ((_local_3 / 2) - (forcedHeight / 2));
                    break;
                case Align.right:
                    x = (((_local_5 + _local_4) - forcedWidth) - margin.right);
                    y = ((_local_3 / 2) - (forcedHeight / 2));
                    break;
                case Align.center:
                    x = ((_local_4 / 2) - (forcedWidth / 2));
                    y = ((_local_3 / 2) - (forcedHeight / 2));
                    break;
                case Align.topLeft:
                    x = (_local_5 + margin.left);
                    y = (_local_6 + margin.top);
                    break;
                case Align.topRight:
                    x = (((_local_5 + _local_4) - forcedWidth) - margin.right);
                    y = (_local_6 + margin.top);
                    break;
                case Align.bottomLeft:
                    x = (_local_5 + margin.left);
                    y = (((_local_6 + _local_3) - forcedHeight) - margin.bottom);
                    break;
                case Align.bottomRight:
                    x = (((_local_5 + _local_4) - forcedWidth) - margin.right);
                    y = (((_local_6 + _local_3) - forcedHeight) - margin.bottom);
                    break;
            };
            if (((!(listenResize)) && (!(_arg_1 == Align.none))))
            {
                _arg_2.addEventListener(Event.RESIZE, onResize, false, 0, true);
                listenResize = true;
            };
            this.alignement = _arg_1;
            this.alignTarget = _arg_2;
        }

        private function _onRemovedFromStage(_arg_1:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            removeEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
            dispose();
        }

        public function resize():void
        {
            if (alignement != Align.none)
            {
                alignTo(alignement, alignTarget);
            };
        }

        protected function onResize(_arg_1:Event):void
        {
            resize();
        }


    }
}//package com.google.analytics.debug

