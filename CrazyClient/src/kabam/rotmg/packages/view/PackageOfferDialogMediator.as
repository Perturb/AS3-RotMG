﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.packages.view.PackageOfferDialogMediator

package kabam.rotmg.packages.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.packages.services.GetPackagesTask;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.packages.control.BuyPackageSignal;

    public class PackageOfferDialogMediator extends Mediator 
    {

        [Inject]
        public var getPackageTask:GetPackagesTask;
        [Inject]
        public var view:PackageOfferDialog;
        [Inject]
        public var closeDialogsSignal:CloseDialogsSignal;
        [Inject]
        public var buyPackageSignal:BuyPackageSignal;


        override public function initialize():void
        {
            this.view.buy.add(this.onBuy);
            this.view.close.add(this.onClose);
        }

        override public function destroy():void
        {
            this.view.close.remove(this.onClose);
            this.view.close.remove(this.onBuy);
            this.view.destroy();
        }

        private function onBuy():void
        {
            this.closeDialogsSignal.dispatch();
            this.buyPackageSignal.dispatch(this.view.getPackage());
        }

        private function onClose():void
        {
            this.closeDialogsSignal.dispatch();
        }


    }
}//package kabam.rotmg.packages.view
