module Products 
    class API < Grape::API
        version 'v1'
        format :json
        prefix :api

        resource :products do
        # Obtener todos los productos
            get do
                Product.all
            end
        
            # Obtener un producto por ID
            get ':id' do
                Product.find(params[:id])
            end
        
            # Crear un nuevo producto
            params do
                requires :name, type: String, desc: "Nombre del producto"
                requires :price, type: BigDecimal, desc: "Precio del producto"
                requires :stock, type: Integer, desc: "Cantidad del producto"
            end
            post do
                Product.create!(declared(params))
            end
        
            # Actualizar un producto
            params do
                optional :name, type: String, desc: "Nuevo nombre del producto"
                optional :price, type: BigDecimal, desc: "Nuevo precio del producto"
                optional :stock, type: Integer, desc: "Nueva cantidad del producto"
            end
            put ':id' do
                product = Product.find(params[:id])
                product.update!(declared(params, include_missing: false))
                product
            end
        
            # Eliminar un producto
            delete ':id' do
                Product.find(params[:id]).destroy
            end
        end
    end
end
