# Creative-Coding-12.10-Homework
# Creative-Coding-12.10-Homework
一、灵感来源——点彩派
1.采用短笔触点描技法
点彩派完全采用短笔触点描的技法作画，使画面色调鲜明而活泼。
2.运用色彩的分割理论
点彩派将色调分割成七种原色，即太阳光的七色，作画时即纯用原色小点排列，利用人们眼睛自行把色彩混合，而把调色的工作直接诉诸视觉作用。
3.运用数理的构造
点彩派在构图上运用数理的构造，从色彩的细密分割、面全体布局，以至于整体与部分的关系、人物远近大小关连，均依固定比例分割。

二、作品目标
从点彩派的色彩分割以及其构图方面汲取灵感，希望通过带一定透明度的圆点的不断叠加来重现原有的画作图片。
圆点的色彩通过加权计算后得出并显示。圆点的大小随着绘制不断减小其半径，可以较好的体现绘画时由铺色到细化的过程。
最后绘制出整幅图片。

三、结构设计
1.存储图片变量并替换图片路径
2.绘制画布并限制圆点半径上下限
3.让圆点在画布随机位置出现，间隔为0.1s，并实现其半径规律减小
4.根据距离加权计算颜色并显示
5.运行绘制图片

四、代码实现
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
