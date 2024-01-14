public class JatisSolution {

    public int[] solution(int[] nums, int target) {
        for (int i = 0; i < nums.length; i++) {
            for (int j = i; j < nums.length; j++) {
                int complement = target - nums[i];
                // System.out.println(nums[i]+"i");
                System.out.println(complement);
                System.out.println("Checking pair: (" + nums[i] + ", " + nums[j] + ")");
                if (nums[j] == complement) {
                    System.out.println("Found pair with sum " + target + ": (" + nums[i] + ", " + nums[j] + ")");
                    return new int[]{i, j};
                }
            }
        }
        System.out.println("No pair found with sum " + target);
        throw new IllegalArgumentException("No Data");
    }

    public static void main(String[] args) {
        JatisSolution solution = new JatisSolution();
        int[] nums = {4, 5, 6, 7};
        int target = 10;

        try {
            int[] result = solution.solution(nums, target);
            System.out.println("Result: (" + result[0] + ", " + result[1] + ")");
        } catch (IllegalArgumentException e) {
            System.out.println("Exception: " + e.getMessage());
        }
    }
}
