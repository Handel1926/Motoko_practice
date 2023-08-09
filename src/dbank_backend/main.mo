import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";


// var can be changed let cant be changed
actor DBank{
  stable var currentValue: Float = 100;
  let id =  6789987656;
  Debug.print(debug_show(currentValue, id));
  stable var startTime = Time.now();

  public func topUp(amount: Float){
    currentValue += amount;
    
    Debug.print(debug_show(startTime));
  };

  public func withDraw(amount: Float){
    let tempValue:  Float = currentValue -  amount;
    if (tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else{
      Debug.print("Action Exceeds Available Balance")
    }
  };

  public query func checkBalance(): async Float{
    return currentValue;
  };
  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsed = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsed));
    startTime := currentTime;
  }
}
