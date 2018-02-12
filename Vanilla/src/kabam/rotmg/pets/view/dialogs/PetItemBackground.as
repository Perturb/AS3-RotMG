// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.dialogs.PetItemBackground

package kabam.rotmg.pets.view.dialogs
{
    import flash.display.Sprite;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsPath;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class PetItemBackground extends Sprite 
    {

        private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x545454);
        private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());

        public function PetItemBackground(_arg_1:int, _arg_2:Array)
        {
            var _local_3:Vector.<IGraphicsData> = new <IGraphicsData>[this.backgroundFill_, this.path_, GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0, 0, _arg_1, _arg_1, (_arg_1 / 12), _arg_2, this.path_);
            graphics.drawGraphicsData(_local_3);
        }

    }
}//package kabam.rotmg.pets.view.dialogs

