// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RegistroSimples {
    address public dono;

    struct Documento {
        bytes32 hash;
        uint256 registradoEm;
        bool revogado;
        bool existe;
    }

    mapping(bytes32 => Documento) public documentos;

    event DocumentoRegistrado(bytes32 id, bytes32 hash);
    event DocumentoRevogado(bytes32 id);

    constructor() {
        dono = msg.sender;
    }

    function registrar(bytes32 id, bytes32 hash) public {
        require(msg.sender == dono, "Apenas o dono");
        require(!documentos[id].existe, "Documento ja existe");

        documentos[id] = Documento(hash, block.timestamp, false, true);

        emit DocumentoRegistrado(id, hash);
    }

    function revogar(bytes32 id) public {
        require(msg.sender == dono, "Apenas o dono");
        require(documentos[id].existe, "Documento nao existe");
        require(!documentos[id].revogado, "Ja revogado");

        documentos[id].revogado = true;

        emit DocumentoRevogado(id);
    }

    function estaValido(bytes32 id) public view returns (bool) {
        return documentos[id].existe && !documentos[id].revogado;
    }
}
