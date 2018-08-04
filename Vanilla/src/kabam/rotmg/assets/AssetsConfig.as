// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.assets.AssetsConfig

package kabam.rotmg.assets{
    import robotlegs.bender.framework.api.IConfig;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.assets.services.CharacterFactory;
    import kabam.rotmg.assets.services.IconFactory;

    public class AssetsConfig implements IConfig {

        [Inject]
        public var injector:Injector;


        public function configure():void{
            this.injector.map(CharacterFactory).asSingleton();
            this.injector.map(IconFactory).asSingleton();
        }


    }
}//package kabam.rotmg.assets

