class CropInfoModel {
  String imageUrl;
  String name;
  String description;
  List<Procedure> procedures;
  CropInfoModel(
      {required this.imageUrl,
      required this.name,
      required this.description,
      required this.procedures});
}

class Procedure {
  String title;
  String despt;
  Procedure({required this.title, required this.despt});
}

List<CropInfoModel> cropInfo = [
  CropInfoModel(
      imageUrl:
          "https://images.unsplash.com/photo-1561504935-4e7d4516a2d1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80",
      name: "Rice",
      description:
          "Rice is a vital cereal crop grown globally, particularly in Asia. It is a primary source of carbohydrates for billions of people and serves as a staple food in many cultures. Its cultivation methods vary from flooded paddies to well-drained fields, with different rice varieties suited to diverse climates and culinary preferences.",
      procedures: [
        Procedure(
            title: "1.Prepare the field:",
            despt:
                "Select a suitable area for rice cultivation, prepare the soil by plowing and leveling, and create flooded paddies or well-drained fields, depending on the rice variety and local conditions"),
        Procedure(
            title: "2.Seedling preparation:",
            despt:
                "Grow rice seedlings in a separate nursery field, typically for 25-40 days, and then transplant them into the main field when they reach the appropriate age and size."),
        Procedure(
            title: "3.Water management:",
            despt:
                "Maintain consistent water levels in the fields, ensuring they are flooded during certain growth stages and drained at others to control weeds and pests while promoting healthy rice growth."),
        Procedure(
            title: "4.Fertilization and pest control:",
            despt:
                "Apply fertilizers to provide essential nutrients to the rice plants, and monitor for pests and diseases, using appropriate methods to protect the crop."),
        Procedure(
            title: "5.Harvest and post-harvest:",
            despt:
                "Harvest mature rice grains using machinery or manual labor, dry the harvested rice, and store it properly to prevent spoilage. The rice is then processed to remove the outer husk, bran, and germ, resulting in polished rice ready for consumption.")
      ]),
  CropInfoModel(
    imageUrl:
        "https://images.unsplash.com/photo-1603833665858-e61d17a86224?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1854&q=80",
    name: "Banana",
    description:
        "Banana is a tropical fruit known for its sweet taste and high nutritional value. It is a significant source of potassium and dietary fiber. Bananas are typically grown in warm, tropical climates and require well-drained soil and regular watering. They are harvested when ripe and can be consumed fresh or used in various culinary dishes.",
    procedures: [
      Procedure(
          title: "1. Soil Preparation:",
          despt:
              "Select a well-drained area with loamy soil for banana cultivation. Prepare the soil by adding organic matter and nutrients to ensure healthy growth."),
      Procedure(
          title: "2. Planting:",
          despt:
              "Plant banana suckers or tissue-cultured plants in the prepared soil. Space the plants adequately and provide proper support for the growing banana bunches."),
      Procedure(
          title: "3. Watering and Fertilization:",
          despt:
              "Maintain consistent soil moisture by regular watering, especially during dry periods. Apply balanced fertilizers to promote fruiting and growth."),
      Procedure(
          title: "4. Pest and Disease Management:",
          despt:
              "Monitor for common banana pests and diseases, such as aphids and Panama disease. Implement control measures as needed to protect the crop."),
      Procedure(
          title: "5. Harvesting:",
          despt:
              "Harvest banana bunches when they are fully ripe. Use a sharp knife to cut the bunch from the plant. Bananas can be stored and transported to markets."),
    ],
  ),
  CropInfoModel(
    imageUrl:
        "https://images.unsplash.com/photo-1553787434-dd9eb4ea4d0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1935&q=80",
    name: "Coconut",
    description:
        "Coconut is a versatile tropical fruit known for its refreshing water, nutritious meat, and various by-products. It thrives in coastal regions with sandy, well-drained soil and requires a warm and humid climate for optimal growth. Coconuts are harvested for their water, flesh, and oil, and they play a vital role in many cuisines and industries.",
    procedures: [
      Procedure(
          title: "1. Soil Preparation:",
          despt:
              "Select a coastal area with well-drained sandy soil for coconut cultivation. Ensure proper drainage to prevent waterlogging."),
      Procedure(
          title: "2. Planting:",
          despt:
              "Plant coconut palms in holes dug into the soil, ensuring adequate spacing between trees. Young coconut palms may take several years to bear fruit."),
      Procedure(
          title: "3. Watering and Fertilization:",
          despt:
              "Coconut trees require regular watering, especially during dry spells. Apply organic and mineral fertilizers to enhance growth and fruit production."),
      Procedure(
          title: "4. Pest and Disease Management:",
          despt:
              "Monitor for pests like rhinoceros beetles and diseases like lethal yellowing. Implement pest control measures and disease management strategies to protect the coconut palms."),
      Procedure(
          title: "5. Harvesting:",
          despt:
              "Coconuts are harvested when they are mature, usually between 12 to 14 months. Use specialized tools or climb the tree to collect the coconuts. The water, flesh, and oil can be extracted and used in various culinary and industrial applications."),
    ],
  ),
  CropInfoModel(
    imageUrl:
        "https://images.unsplash.com/photo-1550828520-4cb496926fc9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1933&q=80",
    name: "Pineapple",
    description:
        "Pineapple is a tropical fruit known for its sweet and tangy flavor. It is rich in vitamin C and dietary fiber. Pineapple plants have spiky leaves and produce a single fruit per plant. They thrive in warm climates with well-drained, sandy soil and require regular care for healthy fruit production.",
    procedures: [
      Procedure(
          title: "1. Soil Preparation:",
          despt:
              "Choose a sunny location with well-drained, sandy soil for pineapple cultivation. Prepare the soil by adding organic matter and nutrients to ensure proper growth."),
      Procedure(
          title: "2. Planting:",
          despt:
              "Plant pineapple crowns or slips in the prepared soil, ensuring proper spacing between plants. Pineapples take about 18 to 24 months to mature and produce fruit."),
      Procedure(
          title: "3. Watering and Fertilization:",
          despt:
              "Provide consistent moisture to pineapple plants, especially during dry periods. Apply a balanced fertilizer to encourage fruit development and growth."),
      Procedure(
          title: "4. Pest and Disease Management:",
          despt:
              "Monitor for common pests like mealybugs and diseases like fusarium wilt. Implement pest control measures and disease management strategies to protect the pineapple crop."),
      Procedure(
          title: "5. Harvesting:",
          despt:
              "Pineapples are harvested when they have reached full maturity and have developed a sweet aroma. Use a sharp knife to cut the fruit from the plant. Pineapples can be consumed fresh or used in various culinary dishes."),
    ],
  ),
  CropInfoModel(
    imageUrl:
        "https://images.unsplash.com/photo-1636488771211-9c635f5002e9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
    name: "Black Pepper",
    description:
        "Black pepper, also known as the 'King of Spices,' is a popular spice known for its pungent flavor and culinary versatility. It is derived from the dried berries of the Piper nigrum vine. Black pepper cultivation requires specific conditions, including a tropical climate and well-drained soil. It is harvested at different stages of maturity for various types of pepper, such as black, white, and green.",
    procedures: [
      Procedure(
          title: "1. Soil Preparation:",
          despt:
              "Select a well-drained area with rich, loamy soil for black pepper cultivation. Ensure proper soil pH and organic matter content to support healthy vine growth."),
      Procedure(
          title: "2. Planting:",
          despt:
              "Plant black pepper vines or cuttings in pits or trellises. Provide suitable support structures for the vines to climb and grow. Vines take several years to reach full maturity."),
      Procedure(
          title: "3. Watering and Fertilization:",
          despt:
              "Maintain consistent soil moisture and provide regular watering, especially during dry periods. Apply organic and mineral fertilizers to promote vine growth and pepper production."),
      Procedure(
          title: "4. Pruning and Training:",
          despt:
              "Prune and train the vines to grow on trellises or supports. Proper training helps in better air circulation and sunlight exposure, leading to higher pepper yields."),
      Procedure(
          title: "5. Harvesting:",
          despt:
              "Harvest black pepper berries at different stages of maturity to produce various types of pepper. Collect the berries and dry them to obtain the desired color and flavor. Black pepper is widely used as a spice and seasoning in various cuisines."),
    ],
  ),
];
