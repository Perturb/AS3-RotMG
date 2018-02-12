// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.SuccessAlert

package com.google.analytics.debug
{
    public class SuccessAlert extends Alert 
    {

        public function SuccessAlert(_arg_1:DebugConfiguration, _arg_2:String, _arg_3:Array)
        {
            var _local_4:Align = Align.bottomLeft;
            var _local_5:Boolean = true;
            var _local_6:Boolean;
            if (_arg_1.verbose)
            {
                _arg_2 = ((('<u><span class="uiAlertTitle">Success</span>' + spaces(18)) + "</u>\n\n") + _arg_2);
                _local_4 = Align.center;
                _local_5 = false;
                _local_6 = true;
            };
            super(_arg_2, _arg_3, "uiSuccess", Style.successColor, _local_4, _local_5, _local_6);
        }

    }
}//package com.google.analytics.debug

