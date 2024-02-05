//
//  Network.swift
//  ZMangas
//
//  Created by Miguel Gallego on 5/2/24.
//

import Foundation

protocol DataInteractor {
//    func getEmpleados() async throws -> [Empleado]
//    func updateEmpleado(empleado: Empleado) async throws
}

struct Network: DataInteractor {
    
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postJSON(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    // MARK: - DataInteractor methods
    
//    func getEmpleados() async throws -> [Empleado] {
//        try await getJSON(request: .get(url: .getEmpleados), type: [DTOEmpleado].self).map(\.toEmpleado)
//    }
// 
//    func updateEmpleado(empleado: Empleado) async throws {
//        try await postJSON(request: .post(url: .empleado, data: empleado.toDTOEmpleadoUpdate, method: "PUT"))
//    }
}
