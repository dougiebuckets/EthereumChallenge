pragma solidity >=0.4.21 <0.6.0;
import 'openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol';
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Token is ERC20Mintable,Ownable {
    uint private _startTime;
    uint private _endTime;
    event TokenMinted(address receipient,uint amountMinted);
    event TimeChanged(uint _StartTime, uint _EndTime);

  //@param StartTime and EndTime are the values fed to set private variables '_startTime' and '_endTime' respectively.
  constructor(uint _StartTime, uint _EndTime) public{
      _startTime = _StartTime;
      _endTime = _EndTime;
  }

    //@dev overriding the mint function to check for start and end time and emits TokenMinted event whenever token is minted to an address
    //@return false if time is not between start and end, true if it is and _mint() is successful
    function mint(address to, uint256 value) public returns (bool) {
        if(_startTime <= now && now <= _endTime) {
            _mint(to, value);
            emit TokenMinted(to,value);
            return true;
        }
        else return false;
    }
    //@notice only owner can change timeframe
    //@dev event is emitted when time is changed
    function changeTimeframe(uint _StartTime, uint _EndTime) public onlyOwner{
        _startTime = _StartTime;
        _endTime = _EndTime;
	    emit TimeChanged(_startTime,_endTime);
    }
}