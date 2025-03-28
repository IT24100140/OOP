package utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

    // Append a line with proper line break
    public static void appendToFile(String filePath, String line) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(line.trim());
            writer.newLine(); // ✅ Ensures next entry starts on a new line
        }
    }

    // Read all lines (skips empty lines)
    public static List<String> readAllLines(String filePath) throws IOException {
        List<String> lines = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return lines;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    lines.add(line.trim());
                }
            }
        }
        return lines;
    }

    // Check if email exists
    public static boolean emailExists(String filePath, String email) throws IOException {
        List<String> lines = readAllLines(filePath);
        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length >= 2 && parts[1].trim().equalsIgnoreCase(email.trim())) {
                return true;
            }
        }
        return false;
    }

    // Delete line by email
    public static void deleteLineByEmail(String filePath, String email) throws IOException {
        File file = new File(filePath);
        File tempFile = new File(file.getAbsolutePath() + ".tmp");

        try (
                BufferedReader reader = new BufferedReader(new FileReader(file));
                BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
        ) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 2 && !parts[1].trim().equalsIgnoreCase(email.trim())) {
                    writer.write(line);
                    writer.newLine();
                }
            }
        }

        if (!file.delete() || !tempFile.renameTo(file)) {
            throw new IOException("Failed to update file after deletion.");
        }
    }
}
