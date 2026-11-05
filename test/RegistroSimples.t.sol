// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/RegistraDoc.sol";

contract RegistroSimplesTest is Test {
    RegistroSimples registro;

    function setUp() public {
        registro = new RegistroSimples();
    }

    function testRegistrar() public {
        registro.registrar("doc1", "hash1");
        assertTrue(registro.estaValido("doc1"));
    }

    function testSoODonoRegistra() public {
        vm.prank(address(0xBEEF));
        vm.expectRevert("Apenas o dono");
        registro.registrar("doc1", "hash1");
    }
}