import java.util.List;
import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.Collections;
import java.util.Iterator;
import java.util.Comparator;
import java.io.Writer;
import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.io.FileOutputStream;

public class Q1 implements Runnable {
    private List<Pool> pools;
    private TreeNode<Pool> tree;
    private File inFile;
    private List<Pool> poolOrder;

    // Constructor
    public Q1(File inFile) {
        this.inFile = inFile;
        this.pools = new ArrayList<Pool>();
        this.poolOrder = new ArrayList<Pool>();
    }

    // Runnable interface method
    public void run() {
        generateList();
        organizeList();
        generateTree();
        traverseTree(this.pools.get(0).treeNode);
        outputPath();
        this.tree.toString(0);
    }

    /**
     * Takes the name of the input file specified on construction
     * then takes each of the pools and creates a new Pool object with them.
     * Then takes that pool object and adds it to the ArrayList "Pools"
     */
    private void generateList() {
        try {
            FileReader fileReader = new FileReader(this.inFile);
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            String line;
            while((line = bufferedReader.readLine()) != null) {
                String[] splitLine = line.split(",");
                String tempName = splitLine[0];
                double tempLat = Double.parseDouble(splitLine[1]);
                double tempLon = Double.parseDouble(splitLine[2]);
                Pool tempPool = new Pool(tempLat, tempLon, tempName);
                this.pools.add(tempPool);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Takes the ArrayList "Pools" and organizes the list from West to East
     * using a custom compare operator
     */
    private void organizeList() {
        Collections.sort(this.pools, new Comparator<Pool>() {
            @Override public int compare(Pool p1, Pool p2) {
                double dist = p1.lat - p2.lat;
                if (dist < 0) {
                    return -1;
                } else if (dist == 0) {
                    return 0;
                } else {
                    return 1;
                }
            }
        });
    }

    /**
     * Using the ArrayList "Pool", this funciton creates a new TreeNode using
     * the first in the organized ArrayList "Pool". Then will take the next in the list
     * And look through all the previous added elements and find which one is closest. Then
     * it will append that node to the closest pool's node. 
     */
    private void generateTree() {
        this.tree = new TreeNode<Pool>(this.pools.get(0));
        this.pools.get(0).treeNode = this.tree;
        for (int i = 1; i < this.pools.size(); i++) {
            Pool currPool = this.pools.get(i);
            double minDist = Double.MAX_VALUE;
            int poolIndex = 0;
            for (int j = 0; j < i; j++) {
                Pool comparePool = this.pools.get(j);
                double currDist = currPool.getDist(comparePool);
                if (currDist < minDist) {
                    minDist = currDist;
                    poolIndex = j;
                }
            }
            TreeNode<Pool> parentPool = this.pools.get(poolIndex).treeNode;
            currPool.treeNode = parentPool.addChild(currPool);
        }
    }

    /**
     * This function produces the "PoolOrder" ArrayList by going through the tree
     * in a pre-order traversal. 
     */
    private void traverseTree(TreeNode<Pool> currNode) {
        this.poolOrder.add(currNode.data);
        if (currNode.children != null) {
            currNode.children.forEach((newNode) -> {
                traverseTree(newNode);
            });
        }
    }

    /**
     * This funciton goes through the "PoolOrder" list and writes the pools name and the 
     * total running value of distance between the pools up until the last printed one. 
     */
    private void outputPath() {
        try (Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("path-java.txt"), "utf-8"))) {
            Pool prevPool = this.poolOrder.get(0);
            double totalDist = 0;
            for (int i = 0; i < this.poolOrder.size(); i++) {
                Pool currPool = this.poolOrder.get(i);
                totalDist += currPool.getDist(prevPool);
                writer.write(currPool.name+" "+totalDist+"\n");
                prevPool = currPool;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }  
    }

    /**
     * Main function to run this class and take in the arguments and pass them into the
     * new class thread
     */
    public static void main (String[] args) {
        try {
            if (args.length == 0) {
                throw new IllegalArgumentException();
            }
            File file = new File(args[0]);
            if (!file.exists()) {
                throw new FileNotFoundException();
            }

            new Thread(new Q1(file)).start();
        } catch (IllegalArgumentException e) {
            System.out.println("Missing input parameter try 'java Q1 pools-java.txt'");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
}