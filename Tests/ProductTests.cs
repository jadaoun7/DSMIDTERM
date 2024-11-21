using DSMIDTERM.Models;
using Xunit;

namespace DSMIDTERM.Tests
{
    public class ProductTests
    {
        [Fact]
        public void ProductInitializationTest()
        {
            // Arrange
            var product = new Product
            {
                Id = 1,
                Name = "Product1",
                Price = 10.0m
            };

            // Act & Assert
            Assert.Equal(1, product.Id);
            Assert.Equal("Product1", product.Name);
            Assert.Equal(10.0m, product.Price);
        }

        [Fact]
        public void ProductPriceUpdateTest()
        {
            // Arrange
            var product = new Product
            {
                Id = 2,
                Name = "Product2",
                Price = 20.0m
            };

            // Act
            product.Price = 25.0m;

            // Assert
            Assert.Equal(25.0m, product.Price);
        }
    }
}
