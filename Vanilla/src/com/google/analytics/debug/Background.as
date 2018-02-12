// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.Background

package com.google.analytics.debug
{
    import flash.display.Graphics;

    public class Background 
    {


        public static function drawRounded(_arg_1:*, _arg_2:Graphics, _arg_3:uint=0, _arg_4:uint=0):void
        {
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint = Style.roundedCorner;
            if (((_arg_3 > 0) && (_arg_4 > 0)))
            {
                _local_5 = _arg_3;
                _local_6 = _arg_4;
            }
            else
            {
                _local_5 = _arg_1.width;
                _local_6 = _arg_1.height;
            };
            if (((_arg_1.stickToEdge) && (!(_arg_1.alignement == Align.none))))
            {
                switch (_arg_1.alignement)
                {
                    case Align.top:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, 0, 0, _local_7, _local_7);
                        break;
                    case Align.topLeft:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, 0, 0, 0, _local_7);
                        break;
                    case Align.topRight:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, 0, 0, _local_7, 0);
                        break;
                    case Align.bottom:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, _local_7, _local_7, 0, 0);
                        break;
                    case Align.bottomLeft:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, 0, _local_7, 0, 0);
                        break;
                    case Align.bottomRight:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, _local_7, 0, 0, 0);
                        break;
                    case Align.left:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, 0, _local_7, 0, _local_7);
                        break;
                    case Align.right:
                        _arg_2.drawRoundRectComplex(0, 0, _local_5, _local_6, _local_7, 0, _local_7, 0);
                        break;
                    case Align.center:
                        _arg_2.drawRoundRect(0, 0, _local_5, _local_6, _local_7, _local_7);
                        break;
                };
            }
            else
            {
                _arg_2.drawRoundRect(0, 0, _local_5, _local_6, _local_7, _local_7);
            };
        }


    }
}//package com.google.analytics.debug

