// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

/**
 * @title Owner
 * @dev Set & change owner
 */
contract Owner {

    address private owner; // 상태변수
    
    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner); // 수행에 영향없음. 디버깅용
    
    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner"); // 2
        // 에러 발생시 메시지 출력
        _; 
        // 4 ->
    }
    
    /**
     * @dev Set contract deployer as owner
     */
    constructor() public {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner); // 0을 20바이트 address로 형변환
        // 0x000....0은 소각 주소로 사용됨 
        // 이더리움 재단이 지정한 burn address는 아니긴 함.
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner { // 1
        emit OwnerSet(owner, newOwner); // 3 ->
        owner = newOwner;
    } // 실행 순서가 꼭 koa 미들웨어같다

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }
}