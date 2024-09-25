import CanisterManager "./ic-management-interface";
import ExperimentalCycles "mo:base/ExperimentalCycles";

shared ({ caller = DEPLOYER }) actor class this() = {
    let manager = actor ("aaaaa-aa") : CanisterManager.Self;

    public shared ({ caller }) func createCanister() : async Principal {
        let settings = {
            freezing_threshold = null;
            controllers = ?[DEPLOYER, caller];
            memory_allocation = null;
            compute_allocation = null;
        };
        ExperimentalCycles.add<system>(7_692_307_692 + 1_000_000_000); // cantidad requerida: 7_692_307_692
        (await manager.create_canister({ settings = ?settings})).canister_id;
    };

    public func installWasm(canister : Principal, wasm : [Nat8]) : () {

        // install_code : shared {
        //     arg : [Nat8];
        //     wasm_module : wasm_module;
        //     mode : { #reinstall; #upgrade; #install };
        //     canister_id : canister_id;
        // } -> async ();

        await manager.install_code({
            arg = []; //
            wasm_module = wasm;
            mode = #install;
            canister_id = canister;
        });
    };

};
