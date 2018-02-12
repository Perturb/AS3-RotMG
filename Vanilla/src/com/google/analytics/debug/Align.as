// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.Align

package com.google.analytics.debug
{
    public class Align 
    {

        public static const none:Align = new Align(0, "none");
        public static const top:Align = new Align(1, "top");
        public static const bottom:Align = new Align(2, "bottom");
        public static const right:Align = new Align(16, "right");
        public static const left:Align = new Align(32, "left");
        public static const center:Align = new Align(0x0100, "center");
        public static const topLeft:Align = new Align(33, "topLeft");
        public static const topRight:Align = new Align(17, "topRight");
        public static const bottomLeft:Align = new Align(34, "bottomLeft");
        public static const bottomRight:Align = new Align(18, "bottomRight");

        private var _value:int;
        private var _name:String;

        public function Align(_arg_1:int=0, _arg_2:String="")
        {
            _value = _arg_1;
            _name = _arg_2;
        }

        public function valueOf():int
        {
            return (_value);
        }

        public function toString():String
        {
            return (_name);
        }


    }
}//package com.google.analytics.debug

