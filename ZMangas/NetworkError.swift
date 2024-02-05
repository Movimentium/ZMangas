//
//  NetworkError.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case general(Error)
    case status(Int)
    case noContent
    case json(Error)
    case unknown
    case noHTTP
    
    public var description: String {
        switch self {
        case .general(let error):
            "Error general: \(error.localizedDescription)"
        case .status(let code):
            "Error de status: \(code)"
        case .noContent:
            "Error: contenido no esperado"
        case .json(let error):
            "Error en el JSON: \(error)"
        case .unknown:
            "Error desconocido"
        case .noHTTP:
            "No es una llamada HTTP"
        }
    }
}
