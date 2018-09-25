package teavs.util;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONArray;

import teavs.entity.Depart;

public class TreeBuilderDepart {
	List<Depart> nodes = new ArrayList<>();

    public String buildTree(List<Depart> nodes) {

        TreeBuilderDepart treeBuilder = new TreeBuilderDepart(nodes);

        return treeBuilder.buildJSONTree();
    }

    public TreeBuilderDepart() {
    }

    public TreeBuilderDepart(List<Depart> nodes) {
        super();
        this.nodes = nodes;
    }

    // 构建JSON树形结构
    public String buildJSONTree() {
        List<Depart> nodeTree = buildTree();
        JSONArray jsonArray = (JSONArray) JSONArray.toJSON(nodeTree);
        return jsonArray.toString();
    }

    // 构建树形结构
    public List<Depart> buildTree() {
        List<Depart> treeNodes = new ArrayList<>();
        List<Depart> rootNodes = getRootNodes();
        for (Depart rootNode : rootNodes) {
            buildChildNodes(rootNode);
            treeNodes.add(rootNode);
        }
        return treeNodes;
    }

    // 递归子节点
    public void buildChildNodes(Depart node) {
        List<Depart> children = getChildNodes(node);
        if (!children.isEmpty()) {
            for (Depart child : children) {
                buildChildNodes(child);
            }
            node.setChildren(children);
        }
    }

    // 获取父节点下所有的子节点
    public List<Depart> getChildNodes(Depart pnode) {
        List<Depart> childNodes = new ArrayList<>();
        for (Depart n : nodes) {
            if (pnode.getId()==n.getPid()) {
                childNodes.add(n);
            }
        }
        return childNodes;
    }

    // 判断是否为根节点
    public boolean rootNode(Depart node) {
        boolean isRootNode = true;
        for (Depart n : nodes) {
            if (node.getPid()==n.getId()) {
                isRootNode = false;
                break;
            }
        }
        return isRootNode;
    }

    // 获取集合中所有的根节点
    public List<Depart> getRootNodes() {
        List<Depart> rootNodes = new ArrayList<>();
        for (Depart n : nodes) {
            if (rootNode(n)) {
                rootNodes.add(n);
            }
        }
        return rootNodes;
    }

}
