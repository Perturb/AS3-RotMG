// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.Warning

package com.google.analytics.debug
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.TextEvent;

    public class Warning extends Label 
    {

        private var _timer:Timer;

        public function Warning(_arg_1:String="", _arg_2:uint=3000)
        {
            super(_arg_1, "uiWarning", Style.warningColor, Align.top, false);
            margin.top = 32;
            if (_arg_2 > 0)
            {
                _timer = new Timer(_arg_2, 1);
                _timer.start();
                _timer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete, false, 0, true);
            };
        }

        public function close():void
        {
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        override public function onLink(_arg_1:TextEvent):void
        {
            switch (_arg_1.text)
            {
                case "hide":
                    close();
                    return;
            };
        }

        public function onComplete(_arg_1:TimerEvent):void
        {
            close();
        }


    }
}//package com.google.analytics.debug

