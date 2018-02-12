// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.googleanalytics.GA

package com.company.googleanalytics
{
    import com.google.analytics.GATracker;

    public class GA 
    {

        private static var tracker:GATracker = null;

        public function GA()
        {
            throw (new Error("Don't instance this class"));
        }

        public static function global():GATracker
        {
            return (tracker);
        }

        public static function setTracker(_arg_1:GATracker):void
        {
            GA.tracker = _arg_1;
        }


    }
}//package com.company.googleanalytics

