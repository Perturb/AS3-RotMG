// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.components.PetsTabContentMediator

package kabam.rotmg.pets.view.components
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.pets.data.PetsModel;

    public class PetsTabContentMediator extends Mediator 
    {

        [Inject]
        public var view:PetsTabContentView;
        [Inject]
        public var model:PetsModel;


        override public function initialize():void
        {
            this.view.init(this.model.getActivePet());
        }

        override public function destroy():void
        {
        }


    }
}//package kabam.rotmg.pets.view.components

