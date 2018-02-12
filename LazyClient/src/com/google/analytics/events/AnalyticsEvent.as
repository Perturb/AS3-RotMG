// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.events.AnalyticsEvent

package com.google.analytics.events
{
    import flash.events.Event;
    import com.google.analytics.AnalyticsTracker;

    public class AnalyticsEvent extends Event 
    {

        public static const READY:String = "ready";

        public var tracker:AnalyticsTracker;

        public function AnalyticsEvent(_arg_1:String, _arg_2:AnalyticsTracker, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this.tracker = _arg_2;
        }

        override public function clone():Event
        {
            return (new AnalyticsEvent(type, tracker, bubbles, cancelable));
        }


    }
}//package com.google.analytics.events

