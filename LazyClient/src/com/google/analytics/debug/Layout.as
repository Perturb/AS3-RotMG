// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.Layout

package com.google.analytics.debug
{
    import flash.display.DisplayObject;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import com.google.analytics.GATracker;
    import flash.net.URLRequest;
    import com.google.analytics.core.GIFRequest;

    public class Layout implements ILayout 
    {

        private var _display:DisplayObject;
        private var _infoQueue:Array;
        private var _maxCharPerLine:int = 85;
        private var _hasInfo:Boolean;
        private var _warningQueue:Array;
        private var _hasDebug:Boolean;
        private var _hasWarning:Boolean;
        private var _mainPanel:Panel;
        private var _GRAlertQueue:Array;
        private var _debug:DebugConfiguration;
        public var visualDebug:Debug;
        private var _hasGRAlert:Boolean;

        public function Layout(_arg_1:DebugConfiguration, _arg_2:DisplayObject)
        {
            _display = _arg_2;
            _debug = _arg_1;
            _hasWarning = false;
            _hasInfo = false;
            _hasDebug = false;
            _hasGRAlert = false;
            _warningQueue = [];
            _infoQueue = [];
            _GRAlertQueue = [];
        }

        private function onKey(_arg_1:KeyboardEvent=null):void
        {
            switch (_arg_1.keyCode)
            {
                case _debug.showHideKey:
                    _mainPanel.visible = (!(_mainPanel.visible));
                    return;
                case _debug.destroyKey:
                    destroy();
                    return;
            };
        }

        public function createWarning(_arg_1:String):void
        {
            if (((_hasWarning) || (!(isAvailable()))))
            {
                _warningQueue.push(_arg_1);
                return;
            };
            _arg_1 = _filterMaxChars(_arg_1);
            _hasWarning = true;
            var _local_2:Warning = new Warning(_arg_1, _debug.warningTimeout);
            addToPanel("analytics", _local_2);
            _local_2.addEventListener(Event.REMOVED_FROM_STAGE, _clearWarning, false, 0, true);
            if (_hasDebug)
            {
                visualDebug.writeBold(_arg_1);
            };
        }

        public function bringToFront(_arg_1:DisplayObject):void
        {
            _display.stage.setChildIndex(_arg_1, (_display.stage.numChildren - 1));
        }

        public function createFailureAlert(_arg_1:String):void
        {
            var _local_2:AlertAction;
            if (_debug.verbose)
            {
                _arg_1 = _filterMaxChars(_arg_1);
                _local_2 = new AlertAction("Close", "close", "close");
            }
            else
            {
                _local_2 = new AlertAction("X", "close", "close");
            };
            var _local_3:Alert = new FailureAlert(_debug, _arg_1, [_local_2]);
            addToPanel("analytics", _local_3);
            if (_hasDebug)
            {
                if (_debug.verbose)
                {
                    _arg_1 = _arg_1.split("\n").join("");
                    _arg_1 = _filterMaxChars(_arg_1, 66);
                };
                visualDebug.writeBold(_arg_1);
            };
        }

        public function init():void
        {
            var _local_1:int = 10;
            var _local_2:uint = (_display.stage.stageWidth - (_local_1 * 2));
            var _local_3:uint = (_display.stage.stageHeight - (_local_1 * 2));
            var _local_4:Panel = new Panel("analytics", _local_2, _local_3);
            _local_4.alignement = Align.top;
            _local_4.stickToEdge = false;
            _local_4.title = ("Google Analytics v" + GATracker.version);
            _mainPanel = _local_4;
            addToStage(_local_4);
            bringToFront(_local_4);
            if (_debug.minimizedOnStart)
            {
                _mainPanel.onToggle();
            };
            createVisualDebug();
            _display.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey, false, 0, true);
        }

        public function addToPanel(_arg_1:String, _arg_2:DisplayObject):void
        {
            var _local_4:Panel;
            var _local_3:DisplayObject = _display.stage.getChildByName(_arg_1);
            if (_local_3)
            {
                _local_4 = (_local_3 as Panel);
                _local_4.addData(_arg_2);
            }
            else
            {
                trace((('panel "' + _arg_1) + '" not found'));
            };
        }

        private function _clearInfo(_arg_1:Event):void
        {
            _hasInfo = false;
            if (_infoQueue.length > 0)
            {
                createInfo(_infoQueue.shift());
            };
        }

        private function _filterMaxChars(_arg_1:String, _arg_2:int=0):String
        {
            var _local_6:String;
            var _local_3:* = "\n";
            var _local_4:Array = [];
            var _local_5:Array = _arg_1.split(_local_3);
            if (_arg_2 == 0)
            {
                _arg_2 = _maxCharPerLine;
            };
            var _local_7:int;
            while (_local_7 < _local_5.length)
            {
                _local_6 = _local_5[_local_7];
                while (_local_6.length > _arg_2)
                {
                    _local_4.push(_local_6.substr(0, _arg_2));
                    _local_6 = _local_6.substring(_arg_2);
                };
                _local_4.push(_local_6);
                _local_7++;
            };
            return (_local_4.join(_local_3));
        }

        private function _clearGRAlert(_arg_1:Event):void
        {
            _hasGRAlert = false;
            if (_GRAlertQueue.length > 0)
            {
                createGIFRequestAlert.apply(this, _GRAlertQueue.shift());
            };
        }

        public function createSuccessAlert(_arg_1:String):void
        {
            var _local_2:AlertAction;
            if (_debug.verbose)
            {
                _arg_1 = _filterMaxChars(_arg_1);
                _local_2 = new AlertAction("Close", "close", "close");
            }
            else
            {
                _local_2 = new AlertAction("X", "close", "close");
            };
            var _local_3:Alert = new SuccessAlert(_debug, _arg_1, [_local_2]);
            addToPanel("analytics", _local_3);
            if (_hasDebug)
            {
                if (_debug.verbose)
                {
                    _arg_1 = _arg_1.split("\n").join("");
                    _arg_1 = _filterMaxChars(_arg_1, 66);
                };
                visualDebug.writeBold(_arg_1);
            };
        }

        public function isAvailable():Boolean
        {
            return (!(_display.stage == null));
        }

        public function createAlert(_arg_1:String):void
        {
            _arg_1 = _filterMaxChars(_arg_1);
            var _local_2:Alert = new Alert(_arg_1, [new AlertAction("Close", "close", "close")]);
            addToPanel("analytics", _local_2);
            if (_hasDebug)
            {
                visualDebug.writeBold(_arg_1);
            };
        }

        public function createInfo(_arg_1:String):void
        {
            if (((_hasInfo) || (!(isAvailable()))))
            {
                _infoQueue.push(_arg_1);
                return;
            };
            _arg_1 = _filterMaxChars(_arg_1);
            _hasInfo = true;
            var _local_2:Info = new Info(_arg_1, _debug.infoTimeout);
            addToPanel("analytics", _local_2);
            _local_2.addEventListener(Event.REMOVED_FROM_STAGE, _clearInfo, false, 0, true);
            if (_hasDebug)
            {
                visualDebug.write(_arg_1);
            };
        }

        public function createGIFRequestAlert(message:String, request:URLRequest, ref:GIFRequest):void
        {
            if (_hasGRAlert)
            {
                _GRAlertQueue.push([message, request, ref]);
                return;
            };
            _hasGRAlert = true;
            var f:Function = function ():void
            {
                ref.sendRequest(request);
            };
            message = _filterMaxChars(message);
            var gra:GIFRequestAlert = new GIFRequestAlert(message, [new AlertAction("OK", "ok", f), new AlertAction("Cancel", "cancel", "close")]);
            addToPanel("analytics", gra);
            gra.addEventListener(Event.REMOVED_FROM_STAGE, _clearGRAlert, false, 0, true);
            if (_hasDebug)
            {
                if (_debug.verbose)
                {
                    message = message.split("\n").join("");
                    message = _filterMaxChars(message, 66);
                };
                visualDebug.write(message);
            };
        }

        public function createVisualDebug():void
        {
            if (!visualDebug)
            {
                visualDebug = new Debug();
                visualDebug.alignement = Align.bottom;
                visualDebug.stickToEdge = true;
                addToPanel("analytics", visualDebug);
                _hasDebug = true;
            };
        }

        public function addToStage(_arg_1:DisplayObject):void
        {
            _display.stage.addChild(_arg_1);
        }

        private function _clearWarning(_arg_1:Event):void
        {
            _hasWarning = false;
            if (_warningQueue.length > 0)
            {
                createWarning(_warningQueue.shift());
            };
        }

        public function createPanel(_arg_1:String, _arg_2:uint, _arg_3:uint):void
        {
            var _local_4:Panel = new Panel(_arg_1, _arg_2, _arg_3);
            _local_4.alignement = Align.center;
            _local_4.stickToEdge = false;
            addToStage(_local_4);
            bringToFront(_local_4);
        }

        public function destroy():void
        {
            _mainPanel.close();
            _debug.layout = null;
        }


    }
}//package com.google.analytics.debug

