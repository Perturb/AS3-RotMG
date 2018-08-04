// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.packages.control.InitPackagesCommand

package kabam.rotmg.packages.control{
    import kabam.rotmg.promotions.model.BeginnersPackageModel;
    import kabam.rotmg.packages.services.PackageModel;

    public class InitPackagesCommand {

        [Inject]
        public var beginnersPackageModel:BeginnersPackageModel;
        [Inject]
        public var packageModel:PackageModel;
        [Inject]
        public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;
        [Inject]
        public var packageAvailable:PackageAvailableSignal;


        public function execute():void{
            if (this.beginnersPackageModel.isBeginnerAvailable())
            {
                this.beginnersPackageAvailable.dispatch();
            }
            else
            {
                if (this.packageModel.hasPackages())
                {
                    this.packageAvailable.dispatch();
                };
            };
        }


    }
}//package kabam.rotmg.packages.control

