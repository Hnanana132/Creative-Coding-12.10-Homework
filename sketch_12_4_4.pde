PImage img;  // 存储图片的变量
float minRadius = 3.00;  // 最小半径
float currentRadius = 100.00;  // 初始半径

void setup() {
  size(800, 600);
  img = loadImage("2.jpg");  // 图片路径
  img.resize(width, height);
  background(255);
}

void draw() {

  // 每隔一段时间自动绘制一个色块
  if (frameCount % 6 == 0) {  // 每0.1秒绘制一次
    float x = random(width);
    float y = random(height);

    drawCircle(x, y, currentRadius);

    // 半径递减
    currentRadius = max(currentRadius - 0.02, minRadius);  // 缩小半径，但不小于最小半径
  }
}

void drawCircle(float x, float y, float r) {
  loadPixels();
  float[] newColor = {0, 0, 0, 0};  // 初始颜色
  float totalWeight = 0;  // 总权重

  for (int i = -int(r); i <= int(r); i++) {
    for (int j = -int(r); j <= int(r); j++) {
      float d = dist(i, j, 0, 0);
      if (d <= r) {
        int pixelIndex = constrain((int(y) + j) * width + (int(x) + i), 0, img.pixels.length - 1);
        int pixelColor = img.pixels[pixelIndex];
        float weight = 1.0 - (d / r);  // 权重，根据距离计算

        newColor[0] += red(pixelColor) * weight;
        newColor[1] += green(pixelColor) * weight;
        newColor[2] += blue(pixelColor) * weight;
        newColor[3] += 178 * weight;

        totalWeight += weight;
      }
    }
  }

  if (totalWeight > 0) {
    newColor[0] /= totalWeight;
    newColor[1] /= totalWeight;
    newColor[2] /= totalWeight;
    newColor[3] /= totalWeight;
  }

  int blendedColor = color(newColor[0], newColor[1], newColor[2], newColor[3]);
  fill(blendedColor,70);
  noStroke();
  ellipse(x, y, r * 2, r * 2);
}
