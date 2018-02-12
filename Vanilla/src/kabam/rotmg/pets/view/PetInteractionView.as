// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.PetInteractionView

package kabam.rotmg.pets.view
{
    import flash.display.Sprite;
    import kabam.rotmg.pets.view.dialogs.ClearsPetSlots;
    import com.company.assembleegameclient.util.StageProxy;

    public class PetInteractionView extends Sprite implements ClearsPetSlots 
    {

        public var stageProxy:StageProxy;

        public function PetInteractionView()
        {
            this.stageProxy = new StageProxy(this);
        }

        protected function positionThis():void
        {
            this.x = ((this.stageProxy.getStageWidth() - this.width) * 0.5);
            this.y = ((this.stageProxy.getStageHeight() - this.height) * 0.5);
        }


    }
}//package kabam.rotmg.pets.view

