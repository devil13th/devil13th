package com.design.composite; public class Leaf implements Component{ private String name ; public Leaf(String name) { this.setName(name); } 
@Override //叶节点没有子节点，实现add和remove没有意义，但是这样可以消除叶节点和枝节点的层次差别，使他们具备完全一致的接口 
public void add(Component compent) { throw new UnsupportedOperationException(); } @Override public void remove(Component compent) { throw new UnsupportedOperationException(); } @Override public void display(int i) { for(int m=0;m<i;m++){ System.out.print("-"); } System.out.println(this.getName()); } public String getName() { return name; } public void setName(String name) { this.name = name; } }
}
