package utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

    // Ensure file and parent directory exist
    private static void ensureFileExists(String filePath) throws IOException {
        File file = new File(filePath);
        File parentDir = file.getParentFile();

        if (parentDir != null && !parentDir.exists()) {
            if (!parentDir.mkdirs()) {
                throw new IOException("Failed to create parent directory: " + parentDir.getAbsolutePath());
            }
        }

        if (!file.exists()) {
            if (!file.createNewFile()) {
                throw new IOException("Failed to create file: " + file.getAbsolutePath());
            }
        }
    }

    // Append a line with proper line break
    public static void appendToFile(String filePath, String line) throws IOException {
        ensureFileExists(filePath);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(line.trim());
            writer.newLine(); // Ensures next entry starts on a new line
        }
    }

    // Read all lines (skips empty lines)
    public static List<String> readAllLines(String filePath) throws IOException {
        ensureFileExists(filePath);
        List<String> lines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
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
        ensureFileExists(filePath);
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
