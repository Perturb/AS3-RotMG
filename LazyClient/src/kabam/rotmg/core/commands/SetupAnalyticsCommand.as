// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.core.commands.SetupAnalyticsCommand

package kabam.rotmg.core.commands
{
    import flash.display.DisplayObjectContainer;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.core.service.GoogleAnalytics;

    public class SetupAnalyticsCommand 
    {

        [Inject]
        public var contextView:DisplayObjectContainer;
        [Inject]
        public var setup:ApplicationSetup;
        [Inject]
        public var analytics:GoogleAnalytics;


        public function execute():void
        {
            this.analytics.init(this.contextView.stage, this.setup.getAnalyticsCode());
        }


    }
}//package kabam.rotmg.core.commands

