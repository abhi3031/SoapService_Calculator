//
//  CalculatorTask.swift
//  SoapService_Calculator
//
//  Created by TOPS on 9/25/18.
//  Copyright © 2018 TOPS. All rights reserved.
//

import UIKit

protocol CalculatorDelegate {
    func getAnswer(str:String);
}

class CalculatorTask: NSObject,XMLParserDelegate{
    
    var delegate:CalculatorDelegate?
    
    
    func add(InputA:String,InputB:String) {
        
        let url = URL(string: "http://www.dneonline.com/calculator.asmx");
        let body = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Add xmlns=\"http://tempuri.org/\"><intA>\(InputA)</intA><intB>\(InputB)</intB></Add></soap:Body></soap:Envelope>"
        var request = URLRequest(url: url!);
        request.addValue(String(body.characters.count), forHTTPHeaderField:"Content-Length");
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField:"Content-Type");
        
        request.addValue("http://tempuri.org/Add", forHTTPHeaderField:"SOAPAction");
        request.httpMethod = "POST";
        request.httpBody = body.data(using: String.Encoding.utf8);
        
        let session = URLSession.shared;
        
        
        let datatask = session.dataTask(with:request) { (data1, resp, err) in
            
            if err == nil{
                
                let strep = String(data: data1!, encoding: String.Encoding.utf8);
                
                
                print(strep);
                let parse = XMLParser(data: data1!);
                parse.delegate = self;
                parse.parse();
                
                
                
            }
        }
        datatask.resume();
        
     
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "AddResult" {
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.delegate?.getAnswer(str: string);
       
        print(string)
    }

    
    
    
    
}
