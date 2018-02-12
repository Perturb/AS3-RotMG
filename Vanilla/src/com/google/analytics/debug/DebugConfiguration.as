// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.DebugConfiguration

package com.google.analytics.debug
{
    import flash.ui.Keyboard;
    import flash.utils.getTimer;
    import flash.net.URLRequest;
    import com.google.analytics.core.GIFRequest;

    public class DebugConfiguration 
    {

        private var _verbose:Boolean = false;
        public var GIFRequests:Boolean = false;
        public var showInfos:Boolean = true;
        public var infoTimeout:Number = 1000;
        public var minimizedOnStart:Boolean = false;
        private var _active:Boolean = false;
        public var traceOutput:Boolean = false;
        public var layout:ILayout;
        public var warningTimeout:Number = 1500;
        public var javascript:Boolean = false;
        public var showWarnings:Boolean = true;
        private var _visualInitialized:Boolean = false;

        private var _mode:VisualDebugMode = VisualDebugMode.basic;
        public var showHideKey:Number = Keyboard.SPACE;
        public var destroyKey:Number = Keyboard.BACKSPACE;


        public function get verbose():Boolean
        {
            return (_verbose);
        }

        public function set verbose(_arg_1:Boolean):void
        {
            _verbose = _arg_1;
        }

        public function set mode(_arg_1:*):void
        {
            if ((_arg_1 is String))
            {
                switch (_arg_1)
                {
                    case "geek":
                        _arg_1 = VisualDebugMode.geek;
                        break;
                    case "advanced":
                        _arg_1 = VisualDebugMode.advanced;
                        break;
                    case "basic":
                    default:
                        _arg_1 = VisualDebugMode.basic;
                };
            };
            _mode = _arg_1;
        }

        public function success(_arg_1:String):void
        {
            if (layout)
            {
                layout.createSuccessAlert(_arg_1);
            };
            if (traceOutput)
            {
                protected::trace((("[+] " + _arg_1) + " !!"));
            };
        }

        public function get active():Boolean
        {
            return (_active);
        }

        private function _initializeVisual():void
        {
            if (layout)
            {
                layout.init();
                _visualInitialized = true;
            };
        }

        private function _destroyVisual():void
        {
            if (((layout) && (_visualInitialized)))
            {
                layout.destroy();
            };
        }

        public function warning(_arg_1:String, _arg_2:VisualDebugMode=null):void
        {
            if (_filter(_arg_2))
            {
                return;
            };
            if (((layout) && (showWarnings)))
            {
                layout.createWarning(_arg_1);
            };
            if (traceOutput)
            {
                protected::trace((("## " + _arg_1) + " ##"));
            };
        }

        private function _filter(_arg_1:VisualDebugMode=null):Boolean
        {
            return ((_arg_1) && (int(_arg_1) >= int(this.mode)));
        }

        public function failure(_arg_1:String):void
        {
            if (layout)
            {
                layout.createFailureAlert(_arg_1);
            };
            if (traceOutput)
            {
                protected::trace((("[-] " + _arg_1) + " !!"));
            };
        }

        public function get mode():*
        {
            return (_mode);
        }

        public function set active(_arg_1:Boolean):void
        {
            _active = _arg_1;
            if (_active)
            {
                _initializeVisual();
            }
            else
            {
                _destroyVisual();
            };
        }

        protected function trace(_arg_1:String):void
        {
            var _local_7:Array;
            var _local_8:int;
            var _local_2:Array = [];
            var _local_3:* = "";
            var _local_4:* = "";
            if (this.mode == VisualDebugMode.geek)
            {
                _local_3 = (getTimer() + " - ");
                _local_4 = (new Array(_local_3.length).join(" ") + " ");
            };
            if (_arg_1.indexOf("\n") > -1)
            {
                _local_7 = _arg_1.split("\n");
                _local_8 = 0;
                while (_local_8 < _local_7.length)
                {
                    if (_local_7[_local_8] != "")
                    {
                        if (_local_8 == 0)
                        {
                            _local_2.push((_local_3 + _local_7[_local_8]));
                        }
                        else
                        {
                            _local_2.push((_local_4 + _local_7[_local_8]));
                        };
                    };
                    _local_8++;
                };
            }
            else
            {
                _local_2.push((_local_3 + _arg_1));
            };
            var _local_5:int = _local_2.length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                public::trace(_local_2[_local_6]);
                _local_6++;
            };
        }

        public function alert(_arg_1:String):void
        {
            if (layout)
            {
                layout.createAlert(_arg_1);
            };
            if (traceOutput)
            {
                protected::trace((("!! " + _arg_1) + " !!"));
            };
        }

        public function info(_arg_1:String, _arg_2:VisualDebugMode=null):void
        {
            if (_filter(_arg_2))
            {
                return;
            };
            if (((layout) && (showInfos)))
            {
                layout.createInfo(_arg_1);
            };
            if (traceOutput)
            {
                protected::trace(_arg_1);
            };
        }

        public function alertGifRequest(_arg_1:String, _arg_2:URLRequest, _arg_3:GIFRequest):void
        {
            if (layout)
            {
                layout.createGIFRequestAlert(_arg_1, _arg_2, _arg_3);
            };
            if (traceOutput)
            {
                protected::trace(((">> " + _arg_1) + " <<"));
            };
        }


    }
}//package com.google.analytics.debug

