// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.core.service.GoogleAnalytics

package kabam.rotmg.core.service
{
    import com.google.analytics.GATracker;
    import com.company.googleanalytics.GA;
    import flash.display.Stage;

    public class GoogleAnalytics 
    {

        private var tracker:GATracker;


        public function init(_arg_1:Stage, _arg_2:String):void
        {
            this.tracker = new GATracker(_arg_1, _arg_2);
            GA.setTracker(this.tracker);
        }

        public function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Number):Boolean
        {
            return (this.tracker.trackEvent(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function trackPageView(_arg_1:String):void
        {
            this.tracker.trackPageview(_arg_1);
        }


    }
}//package kabam.rotmg.core.service

