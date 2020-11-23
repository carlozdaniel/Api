# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
    "openapi": "3.0.0",
    "info": {
      "version": "1.0.0",
      "title": "Swagger Petstore",
      "license": {
        "name": "MIT"
      }
    },
    "servers": [
      {
        "url": "http://petstore.swagger.io/v1"
      }
    ],
    "paths": {
      "/pets": {
        "get": {
          "summary": "List all pets",
          "operationId": "listPets",
          "tags": [
            "pets"
          ],
          "parameters": [
            {
              "name": "limit",
              "in": "query",
              "description": "How many items to return at one time (max 100)",
              "required": false,
              "schema": {
                "type": "integer",
                "format": "int32"
              }
            }
          ],
          "responses": {
            "200": {
              "description": "A paged array of pets",
              "headers": {
                "x-next": {
                  "description": "A link to the next page of responses",
                  "schema": {
                    "type": "string"
                  }
                }
              },
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/Pets"
                  }
                }
              }
            },
            "default": {
              "description": "unexpected error",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/Error"
                  }
                }
              }
            }
          }
        },
        "post": {
          "summary": "Create a pet",
          "operationId": "createPets",
          "tags": [
            "pets"
          ],
          "responses": {
            "201": {
              "description": "Null response"
            },
            "default": {
              "description": "unexpected error",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/Error"
                  }
                }
              }
            }
          }
        }
      },
      "/pets/{petId}": {
        "get": {
          "summary": "Info for a specific pet",
          "operationId": "showPetById",
          "tags": [
            "pets"
          ],
          "parameters": [
            {
              "name": "petId",
              "in": "path",
              "required": true,
              "description": "The id of the pet to retrieve",
              "schema": {
                "type": "string"
              }
            }
          ],
          "responses": {
            "200": {
              "description": "Expected response to a valid request",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/Pet"
                  }
                }
              }
            },
            "default": {
              "description": "unexpected error",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/Error"
                  }
                }
              }
            }
          }
        }
      }
    },
    "components": {
      "schemas": {
        "Pet": {
          "type": "object",
          "required": [
            "id",
            "name"
          ],
          "properties": {
            "id": {
              "type": "integer",
              "format": "int64"
            },
            "name": {
              "type": "string"
            },
            "tag": {
              "type": "string"
            }
          }
        },
        "Pets": {
          "type": "array",
          "items": {
            "$ref": "#/components/schemas/Pet"
          }
        },
        "Error": {
          "type": "object",
          "required": [
            "code",
            "message"
          ],
          "properties": {
            "code": {
              "type": "integer",
              "format": "int32"
            },
            "message": {
              "type": "string"
            }
          }
        }
      }
    }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
