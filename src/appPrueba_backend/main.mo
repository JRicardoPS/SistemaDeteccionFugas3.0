actor {
  type Fuga = {
    cantidadAgua: Nat;
    ubicacion: Text;
    estadoReparacion: Text;
  };

  var fugas : [Fuga] = [];

  public func agregarFuga(cantidadAgua : Nat, ubicacion : Text, estadoReparacion : Text) : async () {
    let nuevaFuga : Fuga = {
      cantidadAgua = cantidadAgua;
      ubicacion = ubicacion;
      estadoReparacion = estadoReparacion;
    };
    fugas := fugas # [nuevaFuga];
  };

  public query func obtenerFugas() : async [Fuga] {
    return fugas;
  };
};
