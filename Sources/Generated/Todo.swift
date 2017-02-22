import SwiftyJSON

public struct Todo {
    public let id: String?
    public let title: String?
    public let completed: Bool?

    public init(id: String?, title: String?, completed: Bool?) {
        self.id = id
        self.title = title
        self.completed = completed
    }

    public init(json: JSON) throws {
        // Required properties

        // Optional properties
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        self.id = json["id"].string
        if json["title"].exists() &&
           json["title"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "title", type: "string", value: json["title"].description, valueType: String(describing: json["title"].type))
        }
        self.title = json["title"].string
        if json["completed"].exists() &&
           json["completed"].type != .bool {
            throw ModelError.propertyTypeMismatch(name: "completed", type: "boolean", value: json["completed"].description, valueType: String(describing: json["completed"].type))
        }
        self.completed = json["completed"].bool ?? false

        // Check for extraneous properties
        if let jsonProperties = json.dictionary?.keys {
            let properties: [String] = ["id", "title", "completed"]
            for jsonPropertyName in jsonProperties {
                if !properties.contains(where: { $0 == jsonPropertyName }) {
                    throw ModelError.extraneousProperty(name: jsonPropertyName)
                }
            }
        }
    }

    public func settingID(_ newId: String?) -> Todo {
      return Todo(id: newId, title: title, completed: completed)
    }

    public func updatingWith(json: JSON) throws -> Todo {
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        let id = json["id"].string ?? self.id

        if json["title"].exists() &&
           json["title"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "title", type: "string", value: json["title"].description, valueType: String(describing: json["title"].type))
        }
        let title = json["title"].string ?? self.title

        if json["completed"].exists() &&
           json["completed"].type != .bool {
            throw ModelError.propertyTypeMismatch(name: "completed", type: "boolean", value: json["completed"].description, valueType: String(describing: json["completed"].type))
        }
        let completed = json["completed"].bool ?? self.completed

        return Todo(id: id, title: title, completed: completed)
    }

    public func toJSON() -> JSON {
        var result = JSON([
        ])
        if let id = id {
            result["id"] = JSON(id)
        }
        if let title = title {
            result["title"] = JSON(title)
        }
        if let completed = completed {
            result["completed"] = JSON(completed)
        }

        return result
    }
}
