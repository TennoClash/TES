package teavs.util;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONArray;

import teavs.entity.Indicator;

public class TreeBuilderIndicatorCheck {
	List<Indicator> nodes = new ArrayList<>();

    public String buildTree(List<Indicator> nodes) {

        TreeBuilderIndicatorCheck treeBuilder = new TreeBuilderIndicatorCheck(nodes);

        return treeBuilder.buildJSONTree();
    }

    public TreeBuilderIndicatorCheck() {
    }

    public TreeBuilderIndicatorCheck(List<Indicator> nodes) {
        super();
        this.nodes = nodes;
    }

    // 构建JSON树形结构
    public String buildJSONTree() {
        List<Indicator> nodeTree = buildTree();
        JSONArray jsonArray = (JSONArray) JSONArray.toJSON(nodeTree);
        return jsonArray.toString();
    }

    // 构建树形结构
    public List<Indicator> buildTree() {
        List<Indicator> treeNodes = new ArrayList<>();
        List<Indicator> rootNodes = getRootNodes();
        for (Indicator rootNode : rootNodes) {
            buildChildNodes(rootNode);
            treeNodes.add(rootNode);
        }
        return treeNodes;
    }

    // 递归子节点
    public void buildChildNodes(Indicator node) {
        List<Indicator> children = getChildNodes(node);
        if (!children.isEmpty()) {
            for (Indicator child : children) {
                buildChildNodes(child);
            }
            node.setChildren(children);
        }
    }

    // 获取父节点下所有的子节点
    public List<Indicator> getChildNodes(Indicator pnode) {
        List<Indicator> childNodes = new ArrayList<>();
        for (Indicator n : nodes) {
            if (pnode.getId()==n.getPid()) {
                childNodes.add(n);
            }
        }
        return childNodes;
    }

    // 判断是否为根节点
    public boolean rootNode(Indicator n2) {
        boolean isRootNode = true;
        for (Indicator n : nodes) {
            if (n2.getPid()==n.getId()) {
                isRootNode = false;
                break;
            }
        }
        return isRootNode;
    }

    // 获取集合中所有的根节点
    public List<Indicator> getRootNodes() {
        List<Indicator> rootNodes = new ArrayList<>();
        for (Indicator n : nodes) {
            if (rootNode(n)) {
                rootNodes.add(n);
            }
        }
        return rootNodes;
    }

}
