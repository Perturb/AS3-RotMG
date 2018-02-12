// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.components.PetFuserMediator

package kabam.rotmg.pets.view.components
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.pets.data.PetsModel;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.pets.data.PetSlotsState;

    public class PetFuserMediator extends Mediator 
    {

        [Inject]
        public var view:PetFuser;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var petSlotsState:PetSlotsState;


        override public function initialize():void
        {
            if (!this.petSlotsState.leftSlotPetVO)
            {
                this.petSlotsState.leftSlotPetVO = this.petsModel.getActivePet();
            };
            this.view.initialize(this.petSlotsState);
        }


    }
}//package kabam.rotmg.pets.view.components

