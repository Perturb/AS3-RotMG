// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.campaign.CampaignTracker

package com.google.analytics.campaign
{
    import com.google.analytics.utils.Variables;

    public class CampaignTracker 
    {

        public var content:String;
        public var source:String;
        public var clickId:String;
        public var name:String;
        public var term:String;
        public var medium:String;
        public var id:String;

        public function CampaignTracker(_arg_1:String="", _arg_2:String="", _arg_3:String="", _arg_4:String="", _arg_5:String="", _arg_6:String="", _arg_7:String="")
        {
            this.id = _arg_1;
            this.source = _arg_2;
            this.clickId = _arg_3;
            this.name = _arg_4;
            this.medium = _arg_5;
            this.term = _arg_6;
            this.content = _arg_7;
        }

        public function isValid():Boolean
        {
            if ((((!(id == "")) || (!(source == ""))) || (!(clickId == ""))))
            {
                return (true);
            };
            return (false);
        }

        public function toTrackerString():String
        {
            var _local_1:Array = [];
            _addIfNotEmpty(_local_1, "utmcid=", id);
            _addIfNotEmpty(_local_1, "utmcsr=", source);
            _addIfNotEmpty(_local_1, "utmgclid=", clickId);
            _addIfNotEmpty(_local_1, "utmccn=", name);
            _addIfNotEmpty(_local_1, "utmcmd=", medium);
            _addIfNotEmpty(_local_1, "utmctr=", term);
            _addIfNotEmpty(_local_1, "utmcct=", content);
            return (_local_1.join(CampaignManager.trackingDelimiter));
        }

        private function _addIfNotEmpty(_arg_1:Array, _arg_2:String, _arg_3:String):void
        {
            if (((!(_arg_3 == null)) && (!(_arg_3 == ""))))
            {
                _arg_3 = _arg_3.split("+").join("%20");
                _arg_3 = _arg_3.split(" ").join("%20");
                _arg_1.push((_arg_2 + _arg_3));
            };
        }

        public function fromTrackerString(_arg_1:String):void
        {
            var _local_2:String = _arg_1.split(CampaignManager.trackingDelimiter).join("&");
            var _local_3:Variables = new Variables(_local_2);
            if (_local_3.hasOwnProperty("utmcid"))
            {
                this.id = _local_3["utmcid"];
            };
            if (_local_3.hasOwnProperty("utmcsr"))
            {
                this.source = _local_3["utmcsr"];
            };
            if (_local_3.hasOwnProperty("utmccn"))
            {
                this.name = _local_3["utmccn"];
            };
            if (_local_3.hasOwnProperty("utmcmd"))
            {
                this.medium = _local_3["utmcmd"];
            };
            if (_local_3.hasOwnProperty("utmctr"))
            {
                this.term = _local_3["utmctr"];
            };
            if (_local_3.hasOwnProperty("utmcct"))
            {
                this.content = _local_3["utmcct"];
            };
            if (_local_3.hasOwnProperty("utmgclid"))
            {
                this.clickId = _local_3["utmgclid"];
            };
        }


    }
}//package com.google.analytics.campaign

