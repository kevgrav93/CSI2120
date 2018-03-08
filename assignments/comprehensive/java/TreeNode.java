import java.util.List;
import java.util.ArrayList;

public class TreeNode<T> {
    public T data;
    public TreeNode<T> parent;
    public List<TreeNode<T>> children;

    /**
     * Constructor
     * @param data    Takes the data input and applies it to itself
     */
    public TreeNode(T data) {
        this.data = data;
        this.children = new ArrayList<TreeNode<T>>();
    }

    /**
     * Adds a new child TreeNode to this TreeNode and returns the new child TreeNode
     * @param child    The child data to be added to this TreeNode
     * @return         The new TreeNode made with the child data
     */
    public TreeNode<T> addChild(T child) {
        TreeNode<T> childNode = new TreeNode<T>(child);
        childNode.parent = this;
        this.children.add(childNode);
        return childNode;
    }

    /**
     * Prints the tree (kinda ugly but gives you the idea)
     * @param depth    Depth of the current node, indicates number of spaces to print
     */
    public void toString(int depth) {
        for (int i = 0; i< depth; i++) {
            System.out.print("  ");
        }
        Pool tempPool = (Pool) this.data;
        System.out.println(tempPool.name);
        if (this.children != null) {
            this.children.forEach((node) -> {
                node.toString(depth+1);
            });
        }
    }
}