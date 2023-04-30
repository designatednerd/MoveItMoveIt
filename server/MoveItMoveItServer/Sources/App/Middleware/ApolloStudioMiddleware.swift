//
//  ApolloStudioMiddleware.swift
//  
//
//  Created by Ellen Shapiro on 4/30/23.
//

import Vapor

struct ApolloStudioMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
           next.respond(to: request).map { response in
               response.headers.add(name: "access-control-allow-origin", value: "https://studio.apollographql.com")
               return response
           }
       }
}


