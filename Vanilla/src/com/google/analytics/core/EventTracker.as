// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.core.EventTracker

package com.google.analytics.core
{
    import com.google.analytics.v4.GoogleAnalyticsAPI;

    public class EventTracker 
    {

        private var _parent:GoogleAnalyticsAPI;
        public var name:String;

        public function EventTracker(_arg_1:String, _arg_2:GoogleAnalyticsAPI)
        {
            this.name = _arg_1;
            _parent = _arg_2;
        }

        public function trackEvent(_arg_1:String, _arg_2:String=null, _arg_3:Number=NaN):Boolean
        {
            return (_parent.trackEvent(name, _arg_1, _arg_2, _arg_3));
        }


    }
}//package com.google.analytics.core

